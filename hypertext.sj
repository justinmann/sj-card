hypertext(
    writer : 'heap #writer

    tag(childTagName : 'string, attrs : empty'hash![string, string], cb : empty'(:hypertext)void) {
        writer.write("<")
        writer.write(childTagName)
        ifValid attrs {
            attrs.each(^{
                writer.write(" ")
                writer.write(_1)
                writer.write("=\"")
                writer.write(_2)
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