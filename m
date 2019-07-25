From: Maxim Mikityanskiy <maximmi@mellanox.com>
Date: Thu, 25 Jul 2019 09:43:06 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next v3 08/11] samples/bpf: add
 unaligned chunks mode support to xdpsock
In-Reply-To: <20190724051043.14348-9-kevin.laatz@intel.com>
References: <20190716030637.5634-1-kevin.laatz@intel.com>
 <20190724051043.14348-1-kevin.laatz@intel.com>
 <20190724051043.14348-9-kevin.laatz@intel.com>
Message-ID: <fd7b6b71-5bfd-986a-b288-b9e3478acebb@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-07-24 08:10, Kevin Laatz wrote:
> This patch adds support for the unaligned chunks mode. The addition of the
> unaligned chunks option will allow users to run the application with more
> relaxed chunk placement in the XDP umem.
> 
> Unaligned chunks mode can be used with the '-u' or '--unaligned' command
> line options.
> 
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
> ---
>   samples/bpf/xdpsock_user.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)

<...>

> @@ -372,6 +378,7 @@ static void usage(const char *prog)
>   		"  -z, --zero-copy      Force zero-copy mode.\n"
>   		"  -c, --copy           Force copy mode.\n"
>   		"  -f, --frame-size=n   Set the frame size (must be a power of two, default is %d).\n"

Help text for -f has to be updated, it doesn't have to be a power of two 
if -u is specified.

> +		"  -u, --unaligned	Enable unaligned chunk placement\n"

<...>

>   
> -	if (opt_xsk_frame_size & (opt_xsk_frame_size - 1)) {
> +	if ((opt_xsk_frame_size & (opt_xsk_frame_size - 1)) &&
> +			!opt_unaligned_chunks) {
>   		fprintf(stderr, "--frame-size=%d is not a power of two\n",
>   			opt_xsk_frame_size);
>   		usage(basename(argv[0]));
> 

