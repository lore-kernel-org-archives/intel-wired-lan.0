From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 4 Feb 2021 11:52:20 -0800
Subject: [Intel-wired-lan] [PATCH RESEND v3 net-next 4/5] net: use the
 new dev_page_is_reusable() instead of private versions
In-Reply-To: <20210202133030.5760-5-alobakin@pm.me>
References: <20210202133030.5760-1-alobakin@pm.me>
 <20210202133030.5760-5-alobakin@pm.me>
Message-ID: <20210204115220.0000018d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Lobakin wrote:

> Now we can remove a bunch of identical functions from the drivers and
> make them use common dev_page_is_reusable(). All {,un}likely() checks
> are omitted since it's already present in this helper.
> Also update some comments near the call sites.
> 
> Suggested-by: David Rientjes <rientjes@google.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>

I don't know why it was missed in the series update, but:
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
