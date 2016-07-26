From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 26 Jul 2016 10:56:28 -0700
Subject: [Intel-wired-lan] [next PATCH S40 01/13] i40e: Fix a bug where
 a client close can be called before an open is complete
In-Reply-To: <1469488555-28187-2-git-send-email-bimmy.pujari@intel.com>
References: <1469488555-28187-1-git-send-email-bimmy.pujari@intel.com>
 <1469488555-28187-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <1469555788.2851.13.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-07-25 at 16:15 -0700, Bimmy Pujari wrote:
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> The client->open call in this path was not protected with the
> client instance mutex. And hence the client->close can get initiated
> before the open completes.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-Id: I0ed60c38868dd3f44966b6ed49a063d0e5b7edf5
> ---
> ?drivers/net/ethernet/intel/i40e/i40e_client.c | 2 ++
> ?1 file changed, 2 insertions(+)

This does not apply cleanly to the current net-next tree. ?It appears that
this series was based on an old/stale version of my next-queue branch. ?So
I am dropping the series, please update/rebase your series to my current
next-queue branch and resubmit.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160726/dab9ffb0/attachment.asc>
