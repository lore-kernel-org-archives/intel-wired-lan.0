From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 18 Nov 2015 15:12:47 -0800
Subject: [Intel-wired-lan] [net PATCH] i40e/i40evf: avoid mutex re-init
In-Reply-To: <1447869701-3883-1-git-send-email-jesse.brandeburg@intel.com>
References: <1447869701-3883-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <20151118151247.00002b0d@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 18 Nov 2015 10:01:41 -0800
Jesse Brandeburg <jesse.brandeburg@intel.com> wrote:

> If the driver were to happen to have a mutex held while
> the i40e_init_adminq call was called, the init_adminq might
> inadvertently call mutex_init on a lock that was held
> which is a violation of the calling semantics.
> 
> Fix this by avoiding adminq.c code allocating/freeing this memory, and
> then do the same work only once in probe/remove.
> 
> Testing Hints (Required if no HSD): for VF, load i40evf in bare metal
> and echo 32 > sriov_numvfs; echo 0 > sriov_numvfs in a loop.  Yes this
> is a horrible thing to do.
> 
> Reported-by: Stefan Assmann <sassmann@redhat.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ida263c51b34e195252179e7e5e400d73a99be7a2

This patch has a bug, v2 will be sent.
