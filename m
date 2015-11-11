From: William Dauchy <william@gandi.net>
Date: Wed, 11 Nov 2015 22:34:58 +0100
Subject: [Intel-wired-lan] regression in ixgbe SFP detection patch
In-Reply-To: <87618083B2453E4A8714035B62D67992504DF0AA@FMSMSX105.amr.corp.intel.com>
References: <20151111173527.GA3641@gandi.net>
 <87618083B2453E4A8714035B62D67992504DF0AA@FMSMSX105.amr.corp.intel.com>
Message-ID: <20151111213458.GD3641@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Nov11 20:33, Tantilov, Emil S wrote:
> If the diff above is the patch you are referring to then you will break the
> SFP+ detection in the case where the driver was loaded while there were no
> SFP+ modules present in the cages.

understood, I was surprised of the modification of behavior. 
-- 
William
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151111/e350c5f5/attachment.asc>
