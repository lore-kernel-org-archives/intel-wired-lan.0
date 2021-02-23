From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 23 Feb 2021 12:22:07 -0800
Subject: [Intel-wired-lan] [RFC PATCH 4/4] i40e: don't open i40iw client
 for kdump
In-Reply-To: <20210222070701.16416-5-coxu@redhat.com>
References: <20210222070701.16416-1-coxu@redhat.com>
 <20210222070701.16416-5-coxu@redhat.com>
Message-ID: <20210223122207.08835e0b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 22 Feb 2021 15:07:01 +0800 Coiby Xu wrote:
> i40iw consumes huge amounts of memory. For example, on a x86_64 machine,
> i40iw consumed 1.5GB for Intel Corporation Ethernet Connection X722 for
> for 1GbE while "craskernel=auto" only reserved 160M. With the module
> parameter "resource_profile=2", we can reduce the memory usage of i40iw
> to ~300M which is still too much for kdump.
> 
> Disabling the client registration would spare us the client interface
> operation open , i.e., i40iw_open for iwarp/uda device. Thus memory is
> saved for kdump.
> 
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Is i40iw or whatever the client is not itself under a CONFIG which
kdump() kernels could be reasonably expected to disable?
