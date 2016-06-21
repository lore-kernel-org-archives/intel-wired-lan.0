From: Paolo Abeni <pabeni@redhat.com>
Date: Tue, 21 Jun 2016 10:46:54 +0200
Subject: [Intel-wired-lan] [PATCH 1/2] fm10k: napi polling routine must
 return actual work done
In-Reply-To: <20160620173933.5638-1-jacob.e.keller@intel.com>
References: <20160620173933.5638-1-jacob.e.keller@intel.com>
Message-ID: <1466498814.11695.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2016-06-20 at 10:39 -0700, Jacob Keller wrote:
> When fm10k_poll fully cleans rings it returns 0. This is incorrect as it
> messes up the budget accounting in the core napi code. Fix this by
> returning actual work done, capped at budget - 1 since the core doesn't
> expect a return of the full budget when the driver modifies the napi
> status.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Venkatesh Srinivas <venkateshs@google.com>
> Cc: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Paolo Abeni <pabeni@redhat.com>

