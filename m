From: William Dauchy <william@gandi.net>
Date: Thu, 12 Nov 2015 13:22:57 +0100
Subject: [Intel-wired-lan] regression in ixgbe SFP detection patch
In-Reply-To: <424516AF-C3E7-4D00-8889-ED7EA8EF315E@intel.com>
References: <20151111173527.GA3641@gandi.net>
 <87618083B2453E4A8714035B62D67992504DF0AA@FMSMSX105.amr.corp.intel.com>
 <424516AF-C3E7-4D00-8889-ED7EA8EF315E@intel.com>
Message-ID: <20151112122257.GE3641@gandi.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Nov11 22:13, Rustad, Mark D wrote:
> Just so you know, there are patches in queue that will improve this situation in two ways:
> 1) When the I2C probe times out, the code assumes that the cage is empty and does not retry the access until the next probe.
> 2) The driver will use its own private workqueue, so it will not affect the system workqueues at all.

Thanks guys for the details,  I will have a look.
-- 
William
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151112/429bf702/attachment.asc>
