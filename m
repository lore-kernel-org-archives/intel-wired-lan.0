From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Fri, 28 Jun 2019 13:08:02 -0700
Subject: [Intel-wired-lan] [PATCH 00/11] XDP unaligned chunk placement
 support
In-Reply-To: <f6fb0870-b5b4-9aba-bfb5-b4248a95da79@intel.com>
References: <20190620083924.1996-1-kevin.laatz@intel.com>
 <FA8389B9-F89C-4BFF-95EE-56F702BBCC6D@gmail.com>
 <ef7e9469-e7be-647b-8bb1-da29bc01fa2e@intel.com>
 <20190627142534.4f4b8995@cakuba.netronome.com>
 <f0ca817a-02b4-df22-d01b-7bc07171a4dc@intel.com>
 <f6fb0870-b5b4-9aba-bfb5-b4248a95da79@intel.com>
Message-ID: <20190628130802.24a6f22b@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 28 Jun 2019 18:51:37 +0200, Bj?rn T?pel wrote:
> In your example Jakub, how would this look in XDP? Wouldn't the
> timestamp be part of the metadata (xdp_md.data_meta)? Isn't
> data-data_meta (if valid) <= XDP_PACKET_HEADROOM? That was my assumption.

The driver parses the metadata and copies it outside of the prepend
before XDP runs.  Then XDP runs unaware of the prepend contents.  
That's the current situation.

XDP_PACKET_HEADROOM is before the entire frame.  Like this:

    buffer start
  /               DMA addr given to the device
 /              /
v              v
| XDP_HEADROOM | meta data | packet data |

Length of meta data comes in the standard fixed size descriptor.

The metadata prepend is in TV form ("TLV with no length field", length's
implied by type).

> There were some discussion on having meta data length in the struct
> xdp_desc, before AF_XDP was merged, but the conclusion was that this was
> *not* needed, because AF_XDP and the XDP program had an implicit
> contract. If you're running AF_XDP, you also have an XDP program running
> and you can determine the meta data length (and also getting back the
> original buffer).
> 
> So, today in AF_XDP if XDP metadata is added, the userland application
> can look it up before the xdp_desc.addr (just like regular XDP), and how
> the XDP/AF_XDP application determines length/layout of the metadata i
> out-of-band/not specified.
> 
> This is a bit messy/handwavy TBH, so maybe adding the length to the
> descriptor *is* a good idea (extending the options part of the
> xdp_desc)? Less clean though. OTOH the layout of the meta data still
> need to be determined.

Right, the device prepend is not exposed as metadata to XDP.
