From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 5 Jan 2022 11:15:45 -0800
Subject: [Intel-wired-lan] [next-queue,
 v2] i40e: Remove unused RX realloc stat
In-Reply-To: <1641397753-121138-1-git-send-email-jdamato@fastly.com>
References: <1641397753-121138-1-git-send-email-jdamato@fastly.com>
Message-ID: <3b256624-b68f-3105-ca7a-7a8a2e95e0dc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 1/5/2022 7:49 AM, Joe Damato wrote:
> After commit 1a557afc4dd5 ("i40e: Refactor receive routine"),
> rx_stats.realloc_count is no longer being incremented, so remove it.
> 
> The debugfs string was left, but hardcoded to 0. This is intended to
> prevent breaking any existing code / scripts that are parsing debugfs
> for i40e.
> 
> Fixes: 1a557afc4dd5 ("i40e: Refactor receive routine")
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> 
> ---
> v1 -> v2: Fix commit message to include one-line SHA summary. Patch is now
>            based on next-queue.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
