From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 30 Sep 2015 13:50:45 -0700
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 32/134]
 drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c:129:12: warning:
 'ixgbe_get_cs4227_status' defined but not used
In-Reply-To: <8FC88943-9E70-46E7-8DE5-37E4B938A9B9@intel.com>
References: <201509291454.fGmMdfRo%fengguang.wu@intel.com>
 <4CD378B1-8EE8-46CA-A733-68CB5B73E750@intel.com>
 <8FC88943-9E70-46E7-8DE5-37E4B938A9B9@intel.com>
Message-ID: <1443646245.2864.29.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-09-29 at 10:08 -0700, Rustad, Mark D wrote:
> > On Sep 29, 2015, at 9:29 AM, Rustad, Mark D <
> mark.d.rustad at intel.com> wrote:
> > 
> > In my repo this code is deleted by the patch "ixgbe: Remove CS4227
> diagnostic code". It almost seems like part of that patch got dropped
> or something.
> 
> Yes. Most of the patch got lost. How did this happen?

It was most likely due to a merge issue, most likely due to those
function header changes we spoke about earlier.

If your latest patch has everything it supposed to, I can try re
-applying your patch.  If I have issues, I will have you re-generate
your patch based on my next-queue tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150930/7973055e/attachment.asc>
