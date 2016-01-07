From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 6 Jan 2016 17:15:35 -0800
Subject: [Intel-wired-lan] [PATCH] i40e: fix merge bug
In-Reply-To: <1452128791-17584-1-git-send-email-jesse.brandeburg@intel.com>
References: <1452128791-17584-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <20160106171535.00006b3e@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 6 Jan 2016 17:06:31 -0800
Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:

> There was a bug (re-)introduced by a merge error when applying patches.
> This fixes the issue by making the code schedule the work item as
> originally intended for the fix included in commit 0e4425ed641f ("i40e:
> fix: do not sleep in netdev_ops") and broken in commit ea02e90b4b49
> ("i40e: propagate properly").
> 
> Fixes: ea02e90b4b49 ("i40e: propagate properly")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

targeted at net-next, tested on next-queue/dev-queue, please send ASAP
as this standalone patch applied cleanly to davem's net-next/master
when tested just now.
