From: Jonathan Lemon <jonathan.lemon@gmail.com>
Date: Fri, 30 Aug 2019 08:46:26 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next v6 08/12] libbpf: add flags
 to umem config
In-Reply-To: <20190827022531.15060-9-kevin.laatz@intel.com>
References: <20190822014427.49800-1-kevin.laatz@intel.com>
 <20190827022531.15060-1-kevin.laatz@intel.com>
 <20190827022531.15060-9-kevin.laatz@intel.com>
Message-ID: <97813612-8FA6-4A33-B4FA-CF7A99FFC012@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 26 Aug 2019, at 19:25, Kevin Laatz wrote:

> This patch adds a 'flags' field to the umem_config and umem_reg structs.
> This will allow for more options to be added for configuring umems.
>
> The first use for the flags field is to add a flag for unaligned chunks
> mode. These flags can either be user-provided or filled with a default.
>
> Since we change the size of the xsk_umem_config struct, we need to version
> the ABI. This patch includes the ABI versioning for xsk_umem__create. The
> Makefile was also updated to handle multiple function versions in
> check-abi.
>
> Signed-off-by: Kevin Laatz <kevin.laatz@intel.com>
> Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
Acked-by: Jonathan Lemon <jonathan.lemon@gmail.com>
