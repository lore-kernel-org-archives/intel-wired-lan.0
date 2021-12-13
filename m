From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Mon, 13 Dec 2021 18:27:37 +0000
Subject: [Intel-wired-lan] [Patch 2/2] iavf: Prevent reset from being
 scheduled while adapter is being removed
In-Reply-To: <20211208102153.669338-3-jkc@redhat.com>
References: <20211208102153.669338-1-jkc@redhat.com>
 <20211208102153.669338-3-jkc@redhat.com>
Message-ID: <4ebe129aeecda496fcad40377903c14d9d0c2dec.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2021-12-08 at 04:21 -0600, Ken Cox wrote:
> If a reset gets scheduled while the adapter is being removed it can
> cause a panic.
> 
> The work_struct for the reset_task is contained in the iavf_adapter
> structure.? iavf_remove() eventually frees the iavf_adapter structure
> so if there is active work scheduled it can cause a panic.
> 
> Signed-off-by: Ken Cox <jkc@redhat.com>

Like the other patch, this one isn't applying.

Thanks,
Tony
