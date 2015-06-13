From: Jesse Gross <jesse@nicira.com>
Date: Fri, 12 Jun 2015 18:55:22 -0700
Subject: [Intel-wired-lan] [PATCH V3 1/2] ixgbe: Add support for
 UDP-encapsulated tx checksum offload
In-Reply-To: <20150612212342.26842.9852.stgit@mdrustad-wks.jf.intel.com>
References: <20150612211601.26842.30885.stgit@mdrustad-wks.jf.intel.com>
 <20150612212342.26842.9852.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <CAEP_g=9xPmHzwDsOBSLac1=hg68Y=EcDH-26TqqQH2s=jHD0_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, Jun 12, 2015 at 2:23 PM, Mark D Rustad <mark.d.rustad@intel.com> wrote:
> From: Mark Rustad <mark.d.rustad@intel.com>
>
> By using GSO for UDP-encapsulated packets, all ixgbe devices can
> be directed to generate checksums for the inner headers because
> the outer UDP checksum can be zero. So point the machinery at the
> inner headers and have the hardware generate the checksum.
>
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>

Thanks, this looks nice to me now.
