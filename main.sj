library "release-1.0:https://github.com/justinmann/sj-lib-json.git"
include "hypertext1.sj"
include "hypertext.sj"

stringWriter #writer(
    text := ""

    reset() {
        text = ""
        void
    }

    write(s : 'string) {
        text += s
        void
    }
) { this }

jsonValue(
    s : empty'string
    a : empty'array!jsonValue
    h : empty'array!tuple2![string, jsonValue]

    getAt(key : 'string)'jsonValue? {
        ifValid h {
            optionalCopy h.findcb(^{ 
                _.item1 == key 
            })?.item2
        } elseEmpty {
            empty'jsonValue
        }
    }

    asString()'string {
        ifValid s {
            optionalCopy s
        } elseEmpty {
            ifValid a {
                "[" + a as string + "]"
            } elseEmpty {
                ifValid h {
                    "{" + h.map!string(^{
                        "\"" + _.item1 + "\" : " + (_.item2 as string) 
                    }) as string + "}"
                } elseEmpty {
                    ""
                }
            }    
        }
    }
) { this }

jsonValue2(
    s : empty'string
    a : empty'array!jsonValue2
    h : empty'hash![string, jsonValue2]

    getAt(key : 'string)'jsonValue2? {
        ifValid h {
            h[key]
        } elseEmpty {
            empty'jsonValue2
        }
    }

    asString() {
        ifValid s {
            optionalCopy s
        } elseEmpty {
            ""
        }
    }
) { this }

total : 1000 // 100000000
writer : heap stringWriter() as #writer

start1 : clock()

for i : 0 to total {
    data : jsonValue(h : [
        ("title", jsonValue(s : "This is a title"))
        ("parentalAdvisory", jsonValue(s : "This is a parental advisory"))
        ("formatList", jsonValue(a : [
            jsonValue(s : "Format 1")
            jsonValue(s : "Format 2")
        ]))
        ("hasAdultText", jsonValue(s : "true"))
        ("strings", jsonValue(h : [
            ("adult_17481" , jsonValue(s : "Adult Text"))
            ("dp_product_info_energy_class" , jsonValue(s : "Energy Class Level"))
        ]))
        ("energyEfficiencyClass", jsonValue(s : "Energy Class"))
    ])

    writer.reset()
    h : hypertext1(writer)
    render(h, data)

    render(h : 'hypertext1, model : 'jsonValue) {
        h.tag("Section", [ ("id" , "titleSection"), ("spacing" , "none") ], ^{
            _.tag("Heading", [ ("id" , "title"), ("headingLevel" , "1"), ("textSize" , "large"), ("spacing" , "none"), ("textColor" , "secondary") ], ^{
                // _.tag("Text", { "id" : "productTitle", "textSize" : "large"}).join(" ", function (h) {
                //     _.raw(model.title)

                //     if (model.parentalAdvisory) {
                //         _.tag("Text", {id:"parentalAdvisory", cssClass:"a-text-normal", textSize:"medium", textColor:"secondary"})
                //         _.txt(model.parentalAdvisory)
                //     }

                //     if (model.formatList.length > 0) {
                //         h("Text", {textSize:"medium", cssClass:"a-text-normal", textColor:"secondary"}).join(", ", function (h) {
                //             model.formatList.forEach(function (format) {
                //                 h.txt(format)
                //             })
                //         })
                //     }
                // })

                ifValid hasAdultText : model["hasAdultText"] {
                    _.tag("Text", [ ("textSize" , "medium"), ("cssClass" , "a-text-normal"), ("textColor" , "secondary") ], ^{ 
                        _.txt(model["strings"]["adult_17481"]?? as string) 
                    })
                }

                ifValid energyEfficiencyClass : model["energyEfficiencyClass"] {
                    _.tag("Text", [ ("id" , "energyEfficiencyTitleInformation"), ("textSize" , "medium") ], ^{
                        _.txt("[" + (model["strings"]["dp_product_info_energy_class"]?? as string) + " " + energyEfficiencyClass as string + "]")
                    })
                }
            })

            _.tag("Section", [ ("id" , "expandTitleToggle"), ("cssClass" , "expandTitleToggle"), ("spacing" , "none") ])
        })
    }
}

end1 : clock()
debug.writeLine("msec: " + ((end1 - start1) as f64 * 1000.0 / clocks_per_sec as f64).asString())

start2 : clock()

for i : 0 to total {
    data : jsonValue2(h : {
        "title" : jsonValue2(s : "This is a title")
        "parentalAdvisory" : jsonValue2(s : "This is a parental advisory"),
        "formatList" : jsonValue2(a : [
            jsonValue2(s : "Format 1")
            jsonValue2(s : "Format 2")
        ]),
        "hasAdultText" : jsonValue2(s : "true"),
        "strings" : jsonValue2(h : {
            "adult_17481" : jsonValue2(s : "Adult Text")
            "dp_product_info_energy_class" : jsonValue2(s : "Energy Class Level")
        })
        "energyEfficiencyClass" : jsonValue2(s : "Energy Class")
    })

    writer.reset()
    h : hypertext(writer)
    render2(h, data)

    render2(h : 'hypertext, model : 'jsonValue2) {
        h.tag("Section", { "id" : "titleSection", "spacing" : "none" }, ^{
            _.tag("Heading", { "id" : "title", "headingLevel" : "1", "textSize" : "large", "spacing" : "none", "textColor" : "secondary" }, ^{
                // _.tag("Text", { "id" : "productTitle", "textSize" : "large"}).join(" ", function (h) {
                //     _.raw(model.title)

                //     if (model.parentalAdvisory) {
                //         _.tag("Text", {id:"parentalAdvisory", cssClass:"a-text-normal", textSize:"medium", textColor:"secondary"})
                //         _.txt(model.parentalAdvisory)
                //     }

                //     if (model.formatList.length > 0) {
                //         h("Text", {textSize:"medium", cssClass:"a-text-normal", textColor:"secondary"}).join(", ", function (h) {
                //             model.formatList.forEach(function (format) {
                //                 h.txt(format)
                //             })
                //         })
                //     }
                // })

                ifValid hasAdultText : model["hasAdultText"] {
                    _.tag("Text", { "textSize" :"medium", "cssClass" : "a-text-normal", "textColor" : "secondary" }, ^{ 
                        _.txt(model["strings"]["adult_17481"]?? as string) 
                    })
                }

                ifValid energyEfficiencyClass : model["energyEfficiencyClass"] {
                    _.tag("Text", { "id" : "energyEfficiencyTitleInformation", "textSize" : "medium" }, ^{
                        _.txt("[" + (model["strings"]["dp_product_info_energy_class"]?? as string) + " " + energyEfficiencyClass as string + "]")
                    })
                }
            })

            _.tag("Section", { "id" : "expandTitleToggle", "cssClass" : "expandTitleToggle", "spacing" : "none" })
        })
    }
}

end2 : clock()
debug.writeLine("msec: " + ((end2 - start2) as f64 * 1000.0 / clocks_per_sec as f64).asString())

start3 : clock()

for i : 0 to total {
    text : "{\r\n    \"title\" : \"This is a title\",\r\n    \"parentalAdvisory\" : \"This is a parental advisory\",\r\n    \"formatList\" : [\r\n        \"Format 1\",\r\n        \"Format 2\"\r\n    ],\r\n    \"hasAdultText\" : true,\r\n    \"strings\" : {\r\n        \"adult_17481\" : \"Adult Text\",\r\n        \"dp_product_info_energy_class\" : \"Energy Class Level\"\r\n    },\r\n    \"energyEfficiencyClass\" : \"Energy Class\"\r\n}"
    data : json.load(text).root()

    writer.reset()
    h : hypertext(writer)
    render3(h, data)

    render3(h : 'hypertext, model : 'json.value) {
        h.tag("Section", { "id" : "titleSection", "spacing" : "none" }, ^{
            _.tag("Heading", { "id" : "title", "headingLevel" : "1", "textSize" : "large", "spacing" : "none", "textColor" : "secondary" }, ^{
                // _.tag("Text", { "id" : "productTitle", "textSize" : "large"}).join(" ", function (h) {
                //     _.raw(model.title)

                //     if (model.parentalAdvisory) {
                //         _.tag("Text", {id:"parentalAdvisory", cssClass:"a-text-normal", textSize:"medium", textColor:"secondary"})
                //         _.txt(model.parentalAdvisory)
                //     }

                //     if (model.formatList.length > 0) {
                //         h("Text", {textSize:"medium", cssClass:"a-text-normal", textColor:"secondary"}).join(", ", function (h) {
                //             model.formatList.forEach(function (format) {
                //                 h.txt(format)
                //             })
                //         })
                //     }
                // })

                ifValid hasAdultText : model["hasAdultText"] {
                    _.tag("Text", { "textSize" :"medium", "cssClass" : "a-text-normal", "textColor" : "secondary" }, ^{ 
                        _.txt(model["strings"]["adult_17481"]?? as string) 
                    })
                }

                ifValid energyEfficiencyClass : model["energyEfficiencyClass"] {
                    _.tag("Text", { "id" : "energyEfficiencyTitleInformation", "textSize" : "medium" }, ^{
                        _.txt("[" + (model["strings"]["dp_product_info_energy_class"]?? as string) + " " + energyEfficiencyClass as string + "]")
                    })
                }
            })

            _.tag("Section", { "id" : "expandTitleToggle", "cssClass" : "expandTitleToggle", "spacing" : "none" })
        })
    }
}

end3 : clock()
debug.writeLine("msec: " + ((end3 - start3) as f64 * 1000.0 / clocks_per_sec as f64).asString())