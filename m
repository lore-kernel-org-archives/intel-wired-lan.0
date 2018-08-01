From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 01 Aug 2018 13:53:56 -0700
Subject: [Intel-wired-lan] [PATCH v3 01/13] ice: Fix multiple static
 analyser warnings
In-Reply-To: <a4d02981-d08b-3748-cce8-b1025f491222@oracle.com>
References: <20180801034729.3864-1-anirudh.venkataramanan@intel.com>
 <20180801034729.3864-2-anirudh.venkataramanan@intel.com>
 <a4d02981-d08b-3748-cce8-b1025f491222@oracle.com>
Message-ID: <9dc76e7840f2057306cf3d9ced9fbab394addbf3.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2018-08-01 at 11:16 -0700, Shannon Nelson wrote:
> On 7/31/2018 8:47 PM, Anirudh Venkataramanan wrote:
> > This patch fixes the following smatch errors:
> > 
> > 1) Fix "odd binop '0x0 & 0xc'" when performing the bitwise-and with
> > a
> >      constant value of zero
> > (ICE_AQC_GSET_RSS_LUT_TABLE_SIZE_128_FLAG).
> >      Remove a similar bitwise-and with 0 in ice_add_marker_act()
> > and use the
> >      right mask ICE_LG_ACT_GENERIC_OFFSET_M in the expression.
> > 
> > 2) Fix a similar issue "odd binop '0x0 & 0x1800' in
> > ice_req_irq_msix_misc.
> > 
> > 3) Fix "odd binop '0x380000 & 0x7fff8'" in ice_add_marker_act().
> > Also, use
> >      a new define ICE_LG_ACT_GENERIC_OFF_RX_DESC_PROF_IDX instead
> > of magic
> >      number '7'. Also remove the following statement that has
> 
> Message truncated - the "... statement that has ..." what?  Maybe
> Jeff 
> can address this before pushing upstream rather than bothering with
> yet 
> another patchset version.

LOL, I thought for a minute that the patch description got truncated
somehow when I applied the patch, but it appears to be sent out
truncated. :-)

Anirudh, just send out a v4 of just patch 1 of the series, with the
patch description fixed and I will update patch in my tree that is
being tested.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180801/7a812b03/attachment.asc>
