From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Fri, 28 Jun 2019 18:51:37 +0200
Subject: [Intel-wired-lan] [PATCH 00/11] XDP unaligned chunk placement
 support
In-Reply-To: <f0ca817a-02b4-df22-d01b-7bc07171a4dc@intel.com>
References: <20190620083924.1996-1-kevin.laatz@intel.com>
 <FA8389B9-F89C-4BFF-95EE-56F702BBCC6D@gmail.com>
 <ef7e9469-e7be-647b-8bb1-da29bc01fa2e@intel.com>
 <20190627142534.4f4b8995@cakuba.netronome.com>
 <f0ca817a-02b4-df22-d01b-7bc07171a4dc@intel.com>
Message-ID: <f6fb0870-b5b4-9aba-bfb5-b4248a95da79@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-06-28 18:19, Laatz, Kevin wrote:
> On 27/06/2019 22:25, Jakub Kicinski wrote:
>> On Thu, 27 Jun 2019 12:14:50 +0100, Laatz, Kevin wrote:
>>> On the application side (xdpsock), we don't have to worry about the user
>>> defined headroom, since it is 0, so we only need to account for the
>>> XDP_PACKET_HEADROOM when computing the original address (in the default
>>> scenario).
>> That assumes specific layout for the data inside the buffer.? Some NICs
>> will prepend information like timestamp to the packet, meaning the
>> packet would start at offset XDP_PACKET_HEADROOM + metadata len..
> 
> Yes, if NICs prepend extra data to the packet that would be a problem for
> using this feature in isolation. However, if we also add in support for 
> in-order
> RX and TX rings, that would no longer be an issue. However, even for NICs
> which do prepend data, this patchset should not break anything that is 
> currently
> working.

(Late on the ball. I'm in vacation mode.)

In your example Jakub, how would this look in XDP? Wouldn't the
timestamp be part of the metadata (xdp_md.data_meta)? Isn't
data-data_meta (if valid) <= XDP_PACKET_HEADROOM? That was my assumption.

There were some discussion on having meta data length in the struct
xdp_desc, before AF_XDP was merged, but the conclusion was that this was
*not* needed, because AF_XDP and the XDP program had an implicit
contract. If you're running AF_XDP, you also have an XDP program running
and you can determine the meta data length (and also getting back the
original buffer).

So, today in AF_XDP if XDP metadata is added, the userland application
can look it up before the xdp_desc.addr (just like regular XDP), and how
the XDP/AF_XDP application determines length/layout of the metadata i
out-of-band/not specified.

This is a bit messy/handwavy TBH, so maybe adding the length to the
descriptor *is* a good idea (extending the options part of the
xdp_desc)? Less clean though. OTOH the layout of the meta data still
need to be determined.


Bj?rn
