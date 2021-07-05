# cnt-mailer
## About
Takes a (utf-8-encoded) plaintext file and an HTML file and sends them as a multipart email to a specified email address, via a specified SMTP server. We're using with *Centaurus: Journal of the European Society for the History of Science* to send out announcements.

### Why?
In at least some academic disciplines (and quite probably other areas), the primary means of communicating with the entire community is via listserv-style mailing lists. If you want to make an announcement, say about the new issue of your journal, you send it to these lists.

This presents a problem for distributing good-looking, easy to read announcements, though: HTML email is generally expected (whether or not that's a good thing), but many of the older listservs don't support it; and even those that do often offer a digest option that falls back to the plaintext. You really need both good HTML and good plaintext. Modern email clients tend to do a pretty halfhearted job converting HTML to plaintext, though, such that a nice HTML email is often a difficult-to-read plaintext email.

In these cases, it's useful to be able to control the HTML part and the plaintext part separately. That way, you can get good results in both formats. CNT-mailer, in its current incarnation, allows for exactly that.

There's a separate problem with producing new issue announcements for a journal with a long table of contents: it's a pain to do manually. Fortunately, the data tends to be available through either publisher APIs or RSS feeds. It'd be pretty nice to generate the announcements automatically on the basis of that data. CNT-mailer doesn't do that yet, but it will.

## Use

``` sh
cnt-mailer
```

``` 
     --host=ITEM        SMTP host (defaults to gmail)
  -u --user=ITEM        SMTP username
     --sender=ITEM      Email address of sender (defaults to SMTP user)
     --sendername=ITEM  Name of sender (optional)
     --to=ITEM          To address
     --toname=ITEM      To name
     --subject=ITEM     Subject line
  -b --body=ITEM        Text file for plaintext email part
     --html=ITEM        HTML file for HTML email part
  -? --help             Display help message
  -V --version          Print version information
```

## Building
### Prerequisites
- [haskell-stack](https://docs.haskellstack.org/en/stable/README/)

### Build
Clone the repo, then:

``` sh
cd cnt-mailer
stack build
```

### Installation
There's currently no automatic installation. After building, you'll find the binary at:
`.stack-work/dist/PATH/TO/build/cnt-mailer-exe`

## To be implemented
- [ ] More graceful failure behaviour on bad command line arguments
- [ ] Automatic generation of announcements via XML parsing
- [ ] Mode switch for sending out premade HTML and plaintext parts vs automatically generated announcements
