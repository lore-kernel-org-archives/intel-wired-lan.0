From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 24 Nov 2015 13:49:01 -0800
Subject: [Intel-wired-lan] [PATCH 5/5] igb: Add I210 cable fault
	detection to self test
In-Reply-To: <1327466653.305871.1446575860238.JavaMail.zimbra@xes-inc.com>
References: <1327466653.305871.1446575860238.JavaMail.zimbra@xes-inc.com>
Message-ID: <1448401741.3154.9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-11-03 at 12:37 -0600, Aaron Sierra wrote:
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
> ?drivers/net/ethernet/intel/igb/e1000_defines.h |? 13 +-
> ?drivers/net/ethernet/intel/igb/igb_ethtool.c?? | 192
> ++++++++++++++++++++++++-
> ?2 files changed, 199 insertions(+), 6 deletions(-)

This patch does not apply cleanly due to changes to igb_ethtool.c.
?Please update this patch with my current next-queue tree (dev-queue
branch) and resubmit just this patch.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20151124/601f712e/attachment.asc>
