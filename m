From: Daniel Borkmann <daniel@iogearbox.net>
Date: Fri, 15 Feb 2019 15:23:58 +0100
Subject: [Intel-wired-lan] [PATCH bpf-next] net: bpf: remove
 XDP_QUERY_XSK_UMEM enumerator
In-Reply-To: <20190213170729.13845-1-bjorn.topel@gmail.com>
References: <20190213170729.13845-1-bjorn.topel@gmail.com>
Message-ID: <5a6168bd-1848-60e8-b0ff-bb65ce7db460@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 02/13/2019 06:07 PM, Bj?rn T?pel wrote:
> From: Jan Sokolowski <jan.sokolowski@intel.com>
> 
> Commit c9b47cc1fabc ("xsk: fix bug when trying to use both copy and
> zero-copy on one queue id") moved the umem query code to the AF_XDP
> core, and therefore removed the need to query the netdevice for a
> umem.
> 
> This patch removes XDP_QUERY_XSK_UMEM and all code that implement that
> behavior, which is just dead code.
> 
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>

Applied, thanks!
