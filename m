From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 29 Jun 2017 22:24:30 +0000
Subject: [Intel-wired-lan] [PATCH net-next] bpf,
 i40e: report bpf prog id during XDP_QUERY_PROG
In-Reply-To: <bc0cefa09874e2d55d045303c2948e586b58fb5d.1498331301.git.daniel@iogearbox.net>
References: <bc0cefa09874e2d55d045303c2948e586b58fb5d.1498331301.git.daniel@iogearbox.net>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAC22B@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Daniel Borkmann
> Sent: Saturday, June 24, 2017 12:14 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: intel-wired-lan at osuosl.org; Daniel Borkmann <daniel@iogearbox.net>
> Subject: [Intel-wired-lan] [PATCH net-next] bpf, i40e: report bpf prog id
> during XDP_QUERY_PROG
> 
> Fill the XDP prog_id with the id just like we do in other XDP enabled drivers
> such as ixgbe. This is needed so that on dump we can retrieve the attached
> program based on the id, and dump BPF insns, opcodes, etc back to user
> space. Only XDP driver missing this is currently i40e.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Acked-by: John Fastabend <john.fastabend@gmail.com>
> Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  [ Jeff, this should still go into this net-next window, so that
>    XDP_QUERY_PROG is covered for all XDP drivers wrt id. Thanks. ]
> 
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


