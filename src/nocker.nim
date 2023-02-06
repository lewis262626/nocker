import os, logging, httpclient, utils, strformat, strutils, json

var logger = newConsoleLogger(fmtStr="[$time] - $levelname: ")

proc authenticate(image:string): string =
  let client = newHttpClient()
  var response: string
  try:
    response = client.getContent(fmt"{authUrl}/token?service={svcUrl}&scope=repository:library/${image}:pull")
  except HttpRequestError as e:
    logger.log(lvlFatal, "Something went wrong connected to Docker to authenticate: ", e.msg)
    quit()
  let jsonResponse = parseJson(response)
  result = jsonResponse["token"].getStr()

proc getImageManifestDigest(jwt: string, digest: string): string =
  discard

if paramCount() == 0:
  logger.log(lvlFatal, "No image name supplied")
  quit()

let image, digest = split(paramStr(1), ':')



