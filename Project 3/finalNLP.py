#!/usr/bin/env python3

"""
This script takes all pdf and docx files in a certain sub-directory, reads in the text inside, and pastes the content into a .txt file. This pre-processing step creates uniformity for the Spark analytics portion of the project, as well as allows us to use robust file parsing libraries that are not available on the IBM cloud.

This script then scrapes all the data from the txt files and then places them in a CSV so that a Spark  process can do text analytics and predict what the files could be categorized as and compares it to the precategorized files to get an accuracy measurement and all this is done through a naive bayes classifying function from the Spark ML library.
"""

import os, sys, binascii, csv, subprocess
from docx import Document
from tika import parser
from pyspark.sql import SparkSession
from pyspark.sql.functions import regexp_replace,col
from pyspark.ml.feature import CountVectorizer, StringIndexer, RegexTokenizer,StopWordsRemover
from pyspark.ml.classification import NaiveBayes
from pyspark.ml.evaluation import MulticlassClassificationEvaluator

# for root, dirs, files in os.walk("."):
	# for name in files:
		# currentPath = os.path.abspath(os.path.join(root, name))
		# print(currentPath)
		# fileWOExtension = currentPath.split(".")
		# fileWOExtension[len(fileWOExtension)-1] = ".txt"
		# fileWTxtExtension = "".join(fileWOExtension)
		# file, ext = os.path.splitext(name)
				
		# #grabs only the extension
		# ext = ext[1:].upper()
        
    # #Opens pdf and docx extension files, converts contents to string list format and saves in txt file
		# if (ext=='PDF'):
			# file_data = parser.from_file(currentPath)
			# content = file_data['content']
			# text = content.split()
			# f = open(fileWTxtExtension,"w+")
			# text = ' '.join(text).encode('ascii', errors = "ignore").decode()
			# f.write(text)
			# f.close()
		# elif (ext=='DOCX'):
			# in_file = open(currentPath,'rb')
			# document = Document(in_file)
			# fullText = []
			# fullTextString = ''
			# for each in document.paragraphs:
				# eachTextList = each.text.split()
				# fullText = fullText + eachTextList
				# fullTextString = fullTextString + each.text
			# in_file.close()
			# fullTextString = fullTextString.encode('ascii',errors = "ignore").decode()
			# f = open(fileWTxtExtension,"w+")
			# f.write(fullTextString)
			# f.close()


# spark script portion
spark = SparkSession.builder.appName("FileClassification").getOrCreate()

with open('trainingModel.csv', 'w') as csvfile:
	filewriter = csv.writer(csvfile, delimiter = ',')
	filewriter.writerow(["File", "Name", "Extension", "Category", "Data"])
	for root, dirs, files in os.walk("."):
		for filename in files:
			try:
				print(filename)
				currentPath = os.path.abspath(os.path.join(root, filename))
				name, ext = os.path.splitext(filename)
				ext = ext[1:].lower()
				category = os.path.dirname(currentPath).split("\\")
				category = category[len(category)-1]
				currentPath = '{}\{}'.format(root,filename)
				
				if ext == "txt":
					with open(currentPath, 'r', encoding = 'utf-8') as file:
						data = " ".join([word for line in file for word in line.split()]).encode('utf-8')
						try:
							filewriter.writerow([filename, name, ext, category, data])
						except Exception as e:
							print(e)				
				else:
					continue
			except:
				pass
		print()

csvPath = os.path.abspath('trainingModel.csv')
print(csvPath)

files_data = spark.read.csv(csvPath, header = "True")
files_data.show()
data_category = files_data.select("Data","Category")
data_category.show(100)

data_category = data_category.withColumn("Only Str", regexp_replace(col('Data'),'\d+', ''))
data_category.select("Data","Only Str").show()

regexTokenizer = RegexTokenizer(inputCol = "Only Str", outputCol = "Words", pattern = "\\W")
rawWordsDataFrame = regexTokenizer.transform(data_category)
rawWordsDataFrame.select("Words").show()

remover = StopWordsRemover(inputCol = "Words", outputCol = "Filtered")
filteredWordsDataFrame = remover.transform(rawWordsDataFrame)
filteredWordsDataFrame.select("Words", "Filtered").show()

indexer = StringIndexer(inputCol = "Category", outputCol = "Category Index")
feature_data = indexer.fit(filteredWordsDataFrame).transform(filteredWordsDataFrame)
feature_data.select("Category", "Category Index").show(160)

countVec = CountVectorizer(inputCol= "Filtered", outputCol = "Features")
model = countVec.fit(feature_data)
countVecFeatures = model.transform(feature_data)

(trainingData, testData) = countVecFeatures.randomSplit([0.85,0.15])

naiveBayes = NaiveBayes(modelType="multinomial", labelCol = "Category Index", featuresCol = "Features")
nbModel = naiveBayes.fit(trainingData)
nbPredictions = nbModel.transform(testData)
nbPredictions.select("prediction", "Category Index", "Features").show(200)

evaluator = MulticlassClassificationEvaluator(labelCol = "Category Index", predictionCol = "prediction", metricName = "accuracy")
naiveBayesAccuracy = evaluator.evaluate(nbPredictions)
print("accuracy = {}".format(naiveBayesAccuracy))

