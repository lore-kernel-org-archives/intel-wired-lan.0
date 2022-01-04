From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Tue, 4 Jan 2022 23:03:09 +0000
Subject: [Intel-wired-lan] [net-queue,
 PATCH] i40e: Remove unused RX realloc stat
In-Reply-To: <1640042998-117712-1-git-send-email-jdamato@fastly.com>
References: <1640042998-117712-1-git-send-email-jdamato@fastly.com>
Message-ID: <94315a5eb39d8f33cf4956eb300ca0a76bde489b.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2021-12-20 at 15:29 -0800, Joe Damato wrote:
> rx_stats.realloc_count was not being incremented after 1a557afc4dd5,
> so
> remove it.

A couple of nits for you. When referencing a commit, you should include
the title in addition to the SHA [1].

Also, unused code should be sent to next-queue.

Thanks,
Tony

> The debugfs string was left but hardcoded to 0. This is intended to
> prevent breaking any existing code / scripts that are parsing debugfs
> for i40e.
> 
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> Fixes: 1a557afc4dd5 ("i40e: Refactor receive routine")

https://www.kernel.org/doc/html/latest/process/submitting-
patches.html#describe-your-changes

