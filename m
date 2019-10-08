From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Tue, 8 Oct 2019 10:05:48 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 3/4] libbpf: handle AF_XDP
 sockets created with XDP_DIRECT bind flag.
In-Reply-To: <1570515415-45593-4-git-send-email-sridhar.samudrala@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
 <1570515415-45593-4-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <8a71dd88-43d0-e1fd-3a08-ecf431e36954@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-10-08 08:16, Sridhar Samudrala wrote:
> Don't allow an AF_XDP socket trying to bind with XDP_DIRECT bind
> flag when a normal XDP program is already attached to the device,
> 
> Don't attach the default XDP program when AF_XDP socket is created
> with XDP_DIRECT bind flag.
>

I'd like this to be default for xsk.c, and if not supported fall back to 
old code.


> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>   tools/lib/bpf/xsk.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/tools/lib/bpf/xsk.c b/tools/lib/bpf/xsk.c
> index d5f4900e5c54..953b479040cd 100644
> --- a/tools/lib/bpf/xsk.c
> +++ b/tools/lib/bpf/xsk.c
> @@ -454,6 +454,9 @@ static int xsk_setup_xdp_prog(struct xsk_socket *xsk)
>   		return err;
>   
>   	if (!prog_id) {
> +		if (xsk->config.bind_flags & XDP_DIRECT)
> +			return 0;
> +
>   		err = xsk_create_bpf_maps(xsk);
>   		if (err)
>   			return err;
> @@ -464,6 +467,9 @@ static int xsk_setup_xdp_prog(struct xsk_socket *xsk)
>   			return err;
>   		}
>   	} else {
> +		if (xsk->config.bind_flags & XDP_DIRECT)
> +			return -EEXIST;
> +
>   		xsk->prog_fd = bpf_prog_get_fd_by_id(prog_id);
>   		err = xsk_lookup_bpf_maps(xsk);
>   		if (err) {
> 
