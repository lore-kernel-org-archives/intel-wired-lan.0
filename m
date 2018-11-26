From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 26 Nov 2018 15:52:02 -0800
Subject: [Intel-wired-lan] [PATCH net] ixgbe: recognize 1000BaseLX SFP
 modules as 1Gbps
In-Reply-To: <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
References: <20181124205801.67828-1-jelsasser@appneta.com>
 <87efb92z5w.fsf@miraculix.mork.no>
 <40FD0CE5-973C-4A7F-91BD-66C1A1699223@appneta.com>
Message-ID: <937675447ad1ec2665d0b6f70390d498a01255d0.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2018-11-26 at 09:54 -0800, Josh Elsasser wrote:
> Bj?rn Mork <bjorn@mork.no> wrote:
> 
> > Not that it matters much I guess, but I think LX SFPs were
> > unsupported
> > at that time. The LX support appears to have been added under the
> > radar
> > while refactoring ixgbe_setup_sfp_modules_X550em in commit
> > e23f33367882
> > ("ixgbe: Fix 1G and 10G link stability for X550EM_x SFP+")
> 
> Looks like you?re right. Want me to respin with an additional ?Fixes?
> tag?

No need to re-spin the patch, just reply with the additional "Fixes"
tag and if patchwork does not pick it up, I will add it to the patch I
have in my tree for validation and review.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181126/96702f71/attachment-0001.asc>
