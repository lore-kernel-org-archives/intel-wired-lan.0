From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 28 Sep 2015 15:19:29 -0700
Subject: [Intel-wired-lan] [net PATCH] i40e/i40evf: check for stopped
 admin queue
In-Reply-To: <1443478201-47450-1-git-send-email-mitch.a.williams@intel.com>
References: <1443478201-47450-1-git-send-email-mitch.a.williams@intel.com>
Message-ID: <20150928151929.00005dee@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 28 Sep 2015 15:10:01 -0700
Mitch Williams <mitch.a.williams@intel.com> wrote:

> It's possible that while we are waiting for the spinlock, another
> entity (that owns the spinlock) has shut down the admin queue.
> If we then attempt to use the queue, we will panic.
> 
> Add a check for this condition on the receive side. This matches
> an existing check on the send queue side.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>

Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
