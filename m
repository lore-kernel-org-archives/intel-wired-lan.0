From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 23 Aug 2018 08:12:18 -0700
Subject: [Intel-wired-lan] [PATCH v6 01/11] igc: Add skeletal frame for
 Intel(R) 2.5G Ethernet Controller support.
In-Reply-To: <20180823140338.GR3348@calimero.vinschen.de>
References: <20180823070552.12190-1-sasha.neftin@intel.com>
 <20180823140338.GR3348@calimero.vinschen.de>
Message-ID: <017dfb5dc28cc4227a4dd655008a308f919023dc.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-08-23 at 16:03 +0200, Corinna Vinschen wrote:
> On Aug 23 10:05, Sasha Neftin wrote:
> > This patch adds the beginning framework onto which I am going to
> add
> > the igc driver which supports the Intel(R) I225-LM/I225-V 2.5G
> > Ethernet Controller.
> 
> I'm curious.  The code looks very much like the igb code.  Wouldn't
> it
> be simpler and less error prone to add these new NICs to igb, rather
> than creating a new driver by (mostly) copying the code from igb?
> 
> What's the idea behind this?

This new driver is for a new upcoming client part, not server (which is
the igb driver).  Yes, the way that this new client part does resemble
how the igb driver operates, but this new client part will not have
many of the advance features (like SRIOV) that igb uses.  We also want
to keep the igb driver strictly for the 1GbE server devices.

> 
> > Sasha Neftin (v2):
> > update module author, copyright and licence header
> > cosmetic changes
> > 
> > Sasha Neftin (v3):
> > remove unused header files
> > 
> > Sasha Neftin (v4):
> > update brand name
> > fix syntax by input from community
> > replace e1000_ prefix with igc_ prefix
> 
> In theory this is neither necessary, nor does it actually help.
> By keeping the e1000 prefixes it's much easier to compare to the
> other, already existing drivers.
> 
> > Sasha Neftin (v5):
> > no changes
> > 
> > Sasha Neftin (v6):
> > no changes
> 
> Is that an oversight?  If there are no changes in v5 and v6, why
> do we have them?!?

Sasha is just noting that this particular patch did not change in v6,
but other patches did have changes in this new version of the series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180823/b52fee5c/attachment.asc>
