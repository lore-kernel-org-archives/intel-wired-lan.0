From: Corinna Vinschen <vinschen@redhat.com>
Date: Thu, 23 Aug 2018 16:03:38 +0200
Subject: [Intel-wired-lan] [PATCH v6 01/11] igc: Add skeletal frame for
 Intel(R) 2.5G Ethernet Controller support.
In-Reply-To: <20180823070552.12190-1-sasha.neftin@intel.com>
References: <20180823070552.12190-1-sasha.neftin@intel.com>
Message-ID: <20180823140338.GR3348@calimero.vinschen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Aug 23 10:05, Sasha Neftin wrote:
> This patch adds the beginning framework onto which I am going to add
> the igc driver which supports the Intel(R) I225-LM/I225-V 2.5G
> Ethernet Controller.

I'm curious.  The code looks very much like the igb code.  Wouldn't it
be simpler and less error prone to add these new NICs to igb, rather
than creating a new driver by (mostly) copying the code from igb?

What's the idea behind this?

> Sasha Neftin (v2):
> update module author, copyright and licence header
> cosmetic changes
> 
> Sasha Neftin (v3):
> remove unused header files
> 
> Sasha Neftin (v4):
> update brand name
> fix syntax by input from community
> replace e1000_ prefix with igc_ prefix

In theory this is neither necessary, nor does it actually help.
By keeping the e1000 prefixes it's much easier to compare to the
other, already existing drivers.

> Sasha Neftin (v5):
> no changes
> 
> Sasha Neftin (v6):
> no changes

Is that an oversight?  If there are no changes in v5 and v6, why
do we have them?!?


Corinna
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180823/a312b52b/attachment.asc>
