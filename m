From: John Fastabend <john.fastabend@gmail.com>
Date: Mon, 09 Nov 2020 13:10:59 -0800
Subject: [Intel-wired-lan] [PATCH bpf-next 6/6] i40e: use batched xsk Tx
 interfaces to increase performance
In-Reply-To: <1604498942-24274-7-git-send-email-magnus.karlsson@gmail.com>
References: <1604498942-24274-1-git-send-email-magnus.karlsson@gmail.com>
 <1604498942-24274-7-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <5fa9b06383a48_8c0e2087e@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Use the new batched xsk interfaces for the Tx path in the i40e driver
> to improve performance. On my machine, this yields a throughput
> increase of 4% for the l2fwd sample app in xdpsock. If we instead just
> look at the Tx part, this patch set increases throughput with above
> 20% for Tx.
> 
> Note that I had to explicitly loop unroll the inner loop to get to
> this performance level, by using a pragma. It is honored by both clang
> and gcc and should be ignored by versions that do not support
> it. Using the -funroll-loops compiler command line switch on the
> source file resulted in a loop unrolling on a higher level that
> lead to a performance decrease instead of an increase.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |   2 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |   4 +-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    |  14 ++-
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    |   3 +-
>  drivers/net/ethernet/intel/i40e/i40e_xsk.c     | 127 ++++++++++++++++++-------
>  5 files changed, 110 insertions(+), 40 deletions(-)
> 

LGTM, although I mostly just reviewed the API usage. Maciej's seems like
a nice cleanup.

Acked-by: John Fastabend <john.fastabend@gmail.com>
