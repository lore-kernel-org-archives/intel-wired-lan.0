From: Guedes, Andre <andre.guedes@intel.com>
Date: Thu, 7 Sep 2017 21:51:53 +0000
Subject: [Intel-wired-lan] [RFC net-next 0/5] TSN: Add qdisc-based
 config interfaces for traffic shapers
In-Reply-To: <20170907161838.GB9064@sisyphus.home.austad.us>
References: <20170901012625.14838-1-vinicius.gomes@intel.com>
 <20170907053411.GA6580@sisyphus.home.austad.us>
 <20170907124018.deinzo3c4ice3q7n@localhost>
 <20170907152751.GA9064@sisyphus.home.austad.us>
 <20170907155315.5gqy5e4susl25wa2@localhost>
 <20170907161838.GB9064@sisyphus.home.austad.us>
Message-ID: <1504821112.2117.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2017-09-07 at 18:18 +0200, Henrik Austad wrote:
> On Thu, Sep 07, 2017 at 05:53:15PM +0200, Richard Cochran wrote:
> > On Thu, Sep 07, 2017 at 05:27:51PM +0200, Henrik Austad wrote:
> > > On Thu, Sep 07, 2017 at 02:40:18PM +0200, Richard Cochran wrote:
> > > And if you want to this driver to act as a bridge, how do you accomodate?
> > > change in network requirements? (i.e. how does this work with switchdev?)
> >?
> > To my understanding, this Qdisc idea provides QoS for the host's
> > transmitted traffic, and nothing more.
> 
> Ok, then we're on the same page.
> 
> > > - Or am I overthinking this?
> >?
> > Being able to configure the external ports of a switchdev is probably
> > a nice feature, but that is another story.? (But maybe I misunderstood
> > the authors' intent!)
> 
> ok, chalk that one up for later perhaps

Just to clarify, we've been most focused on end-station use-cases. We've
considered some bridge use-cases as well just to verify that the proposed
design won't be an issue if someone else goes for it.

- Andre
-------------- next part --------------
A non-text attachment was scrubbed...
Name: smime.p7s
Type: application/x-pkcs7-signature
Size: 3262 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170907/83455e39/attachment-0001.bin>
