From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Wed, 9 Oct 2019 09:53:58 -0700
Subject: [Intel-wired-lan] [PATCH bpf-next 0/4] Enable direct receive on
 AF_XDP sockets
In-Reply-To: <ce255470-6bf7-0ba4-c24f-0808e3331977@intel.com>
References: <1570515415-45593-1-git-send-email-sridhar.samudrala@intel.com>
 <20191008174919.2160737a@cakuba.netronome.com>
 <ce255470-6bf7-0ba4-c24f-0808e3331977@intel.com>
Message-ID: <20191009095358.34cddd95@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 8 Oct 2019 23:29:59 -0700, Samudrala, Sridhar wrote:
> On 10/8/2019 5:49 PM, Jakub Kicinski wrote:
> > I asked you to add numbers for handling those use cases in the kernel
> > directly.  
> 
> Forgot to explicitly mention that I didn't see any regressions with 
> xdp1, xdp2 or xdpsock in default mode with these patches. Performance 
> remained the same.

I'm not looking for regressions. The in-kernel path is faster, and
should be used for speeding things up rather than a "direct path to
user space". Your comparison should have 3 numbers - current AF_XDP,
patched AF_XDP, in-kernel handling.
