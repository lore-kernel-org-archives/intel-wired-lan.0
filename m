From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 17 Jun 2021 23:25:47 +0000
Subject: [Intel-wired-lan] [PATCH] ice: change return type of
 ice_ptp_request_ts() to s8
In-Reply-To: <20210617215419.3502075-1-trix@redhat.com>
References: <20210617215419.3502075-1-trix@redhat.com>
Message-ID: <c968aedc8f5adf398068293f6f75fcb1a701c597.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2021-06-17 at 14:54 -0700, trix at redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> A gcc 10.3.1 compile error
> ice_ptp.h:149:1: error: return type defaults to
>   'int' [-Werror=return-type]
>   149 | ice_ptp_request_ts(struct ice_ptp_tx *tx, ...
>       | ^~~~~~~~~~~~~~~~~~
> 
> This stub's return needs to match the decl for
> CONFIG_PTP_I588_CLOCK, which matches its use in
> ice_txrt.c
> 
> Change the implicit int return to s8.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---

Thanks for the patch Tom, but Lorenzo recently had the fix accepted for
this[1].

- Tony

[1] https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-
next.git/commit/?id=4d7f75fe8006a1345e6a52b3e3a4c82633f20564

