library "release-1.0:https://github.com/justinmann/sj-lib-json.git"
include "hyperscript.sj"

total : 100000
orig : heap stringWriter()
writer : orig as #writer

start : clock()
for i : 0 to total {
    text : "{\r\n    \"title\" : \"This is a title\",\r\n    \"parentalAdvisory\" : \"This is a parental advisory\",\r\n    \"formatList\" : [\r\n        \"Format 1\",\r\n        \"Format 2\"\r\n    ],\r\n    \"hasAdultText\" : true,\r\n    \"strings\" : {\r\n        \"adult_17481\" : \"Adult Text\",\r\n        \"dp_product_info_energy_class\" : \"Energy Class Level\"\r\n    },\r\n    \"energyEfficiencyClass\" : \"Energy Class\"\r\n}"
    data : json.parse(text)
    ifValid data {
        writer.reset()
        h : hyperscript(writer)
        render4(h, data)

        render4(h : 'hyperscript, model : 'json.value) {
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
}

end : clock()
debug.writeLine("msec: " + ((end - start) as f64 * 1000.0 / clocks_per_sec as f64).asString())