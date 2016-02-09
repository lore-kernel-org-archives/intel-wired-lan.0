From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 09 Feb 2016 11:47:02 +0100
Subject: [Intel-wired-lan] [PATCH v4] igb: Add I210 cable fault
	detection to self test
In-Reply-To: <520205889.412690.1454977910808.JavaMail.zimbra@xes-inc.com>
References: <520205889.412690.1454977910808.JavaMail.zimbra@xes-inc.com>
Message-ID: <1455014822.3592.42.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-02-08 at 18:31 -0600, Aaron Sierra wrote:
> From: Joe Schultz <jschultz@xes-inc.com>
> 
> Add an offline diagnostic test for the I210 internal PHY which checks
> for cable faults and reports the distance along the cable where the
> fault was detected. Fault types detected include open, short, and
> cross-pair short.
> 
> Signed-off-by: Joe Schultz <jschultz@xes-inc.com>
> Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> ---
> ?v2 - account for changes made by this patch in dev-queue:
> ?? drivers/net: get rid of unnecessary initializations in
> .get_drvinfo()
> ?v3 - fix uninitialized variable compile warning
> ??? - remove unneeded igb_cable_fault_test_prep() function
> ??? - don't add unused define to e1000_defines.h
> ??? - only run cable diagnostic if link test fails
> ?v4 - only set no-fault, link-present cable distance for I210
> 
> ?drivers/net/ethernet/intel/igb/e1000_defines.h |? 12 +-
> ?drivers/net/ethernet/intel/igb/igb_ethtool.c?? | 186
> ++++++++++++++++++++++++-
> ?2 files changed, 192 insertions(+), 6 deletions(-)

I try not to be a checkpatch.pl stickler, but your patch clearly has
some style issues that checkpatch.pl complains about and need to be
fixed. ?I have gone ahead and applied your patch to my next-queue tree
(dev-queue branch) so that Aaron can test the functional changes of
your patch.

So I will require a v5 to fix the coding style issues that
checkpatch.pl whines about, but before re-spinning your patch, lets
wait to see if Aaron finds any other issues with your patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160209/b85b7fab/attachment-0001.asc>
