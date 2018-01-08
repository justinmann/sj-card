hypertext1(
    writer : 'heap #writer

    tag(
        childTagName : 'string
        attrs : empty'array!tuple2![string, string]
        cb : empty'(:hypertext1)void
    ) {
        writer.write("<")
        writer.write(childTagName)
        ifValid attrs {
            attrs.each(^{
                writer.write(" ")
                writer.write(_.item1)
                writer.write("=\"")
                writer.write(_.item2)
                writer.write("\"")
            })
        }
        writer.write(">")

        ifValid cb {
            cb(parent)
        }

        writer.write("</")
        writer.write(childTagName)
        writer.write(">")
    }

    txt(s : 'string) {
        writer.write(s.escapeHtml())
    }

    raw(s : 'string) {
        writer.write(s)
    }
) { this }