From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Tue, 17 Sep 2019 12:54:58 +0200
Subject: [Intel-wired-lan] [PATCH bpf-next] i40e: fix xdp handle
 calculations
In-Reply-To: <CAKErNvpe3htU-ETe0y0XQ=SwY047qc3Z3=aHN6g2BbkoGHNNUQ@mail.gmail.com>
References: <20190905011144.3513-1-kevin.laatz@intel.com>
 <CAKErNvpe3htU-ETe0y0XQ=SwY047qc3Z3=aHN6g2BbkoGHNNUQ@mail.gmail.com>
Message-ID: <b1d2a07d-20cc-7410-a296-d5245a2ffe54@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-09-17 12:48, Maxim Mikityanskiy wrote:
> Hi, it looks to me that headroom is still broken after this commit.
> i40e_run_xdp_zc adds it a second time, i.e.:

Indeed, but Ciara fixed that in this series [1]. Thanks for reviewing
the patch!

Cheers,
Bj?rn

[1] 
https://lore.kernel.org/bpf/20190913103948.32053-1-ciara.loftus at intel.com/
