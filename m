From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Fri, 4 Sep 2020 15:59:42 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next 0/6] xsk: exit NAPI loop when
 AF_XDP Rx ring is full
In-Reply-To: <20200904135332.60259-1-bjorn.topel@gmail.com>
References: <20200904135332.60259-1-bjorn.topel@gmail.com>
Message-ID: <0257f769-0f43-a5b7-176d-7c5ff8eaac3a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2020-09-04 15:53, Bj?rn T?pel wrote:
> This series addresses a problem that arises when AF_XDP zero-copy is 
> enabled, and the kernel softirq Rx processing and userland process
> is running on the same core.
> 
[...]
> 

@Maxim I'm not well versed in Mellanox drivers. Would this be relevant 
to mlx5 as well?


Cheers,
Bj?rn
