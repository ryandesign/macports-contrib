#
#   trac.rb
#
#   Plugin to rbot (http://ruby-rbot.org/), an irc bot, to provide
#   services related to MacPorts trac systemfor the #macports channel
#   on freenode.net, created from PortPlugin by James D. Berry
#
#   By Andrea D'Amore <and.damore@macports.org>
#
#   $Id: $

require 'stringio'

class TracPlugin < Plugin

    def help(plugin, topic="")
        case topic
          when "ticket"
            return "ticket <ticket no.> => show http link for ticket <ticket no.>"
          when "faq"
            return "faq => show FAQs' URL"
          when "paste"
            return "paste => show direct pastebin link for #macports channel "
          when "guide"
            return "guide [chunked] => show The Guide's URL. Don't Panic."
          when "team"
            return "team => show link to team page on wiki"
          else
            return "trac module provides: !ticket, !faq, !paste, !guide, !team"
        end

    end

    def ticket(m, params)
        number = params[:number][/^#?(\d*)$/,1]
        if ( number )
            url = "https://trac.macports.org/ticket/"+number
            m.reply "#{url}"
        else
            m.reply "Use either #1234 or 1234 syntax for ticket number"
        end
    end

    def faq(m, params)
        m.reply "FAQs are at: https://trac.macports.org/wiki/FAQ"
    end

    def paste(m, params)
        m.reply "Paste more than 3 rows using: http://paste.lisp.org/new/macports"
    end

    def guide(m, params)
        if ( params[:parm] == "chunked" )
            m.reply "http://guide.macports.org/chunked/index.html"
        else
            m.reply "http://guide.macports.org/"
        end
    end
    
    def team(m, params)
        m.reply "https://trac.macports.org/wiki/MacPortsDevelopers"
    end

end

plugin = TracPlugin.new
plugin.map 'ticket :number',    :action => 'ticket'
plugin.map 'faq',               :action => 'faq'
plugin.map 'paste',             :action => 'paste'
plugin.map 'guide :parm',       :action => 'guide',     :defaults => {:parm => ""}
plugin.map 'team',              :action => 'team'
