From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 12 Sep 2019 11:47:46 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix secpath usage for IPsec TX
 offload.
In-Reply-To: <9d94bd04-c6fa-d275-97bc-5d589304f038@reliablehosting.com>
References: <20190912110144.GS2879@gauss3.secunet.de>
 <9d94bd04-c6fa-d275-97bc-5d589304f038@reliablehosting.com>
Message-ID: <1d831c0ee1800a972c177cc15720f43ed1a6703d.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2019-09-12 at 11:33 -0500, Jonathan Tooker wrote:
> On 9/12/2019 6:01 AM, Steffen Klassert wrote:
> > The ixgbe driver currently does IPsec TX offloading
> > based on an existing secpath. However, the secpath
> > can also come from the RX side, in this case it is
> > misinterpreted for TX offload and the packets are
> > dropped with a "bad sa_idx" error. Fix this by using
> > the xfrm_offload() function to test for TX offload.
> > 
> Does this patch also need to be ported to the ixgbevf driver? I can 
> replicate the bad sa_idx error using a VM that's using a VF & the 
> ixgebvf  driver.
> 

I am putting together a patch for ixgbevf right now.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20190912/ebfd966e/attachment.asc>
