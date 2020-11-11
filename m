From: John Fastabend <john.fastabend@gmail.com>
Date: Wed, 11 Nov 2020 00:40:06 -0800
Subject: [Intel-wired-lan] [PATCH bpf-next v2 4/5] xsk: introduce
 batched Tx descriptor interfaces
In-Reply-To: <1605006094-31097-5-git-send-email-magnus.karlsson@gmail.com>
References: <1605006094-31097-1-git-send-email-magnus.karlsson@gmail.com>
 <1605006094-31097-5-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <5faba36671508_bb26020850@john-XPS-13-9370.notmuch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Magnus Karlsson wrote:
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Introduce batched descriptor interfaces in the xsk core code for the
> Tx path to be used in the driver to write a code path with higher
> performance. This interface will be used by the i40e driver in the
> next patch. Though other drivers would likely benefit from this new
> interface too.
> 
> Note that batching is only implemented for the common case when
> there is only one socket bound to the same device and queue id. When
> this is not the case, we fall back to the old non-batched version of
> the function.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---

Acked-by: John Fastabend <john.fastabend@gmail.com>
