From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Thu, 27 Jun 2019 14:25:34 -0700
Subject: [Intel-wired-lan] [PATCH 00/11] XDP unaligned chunk placement
 support
In-Reply-To: <ef7e9469-e7be-647b-8bb1-da29bc01fa2e@intel.com>
References: <20190620083924.1996-1-kevin.laatz@intel.com>
 <FA8389B9-F89C-4BFF-95EE-56F702BBCC6D@gmail.com>
 <ef7e9469-e7be-647b-8bb1-da29bc01fa2e@intel.com>
Message-ID: <20190627142534.4f4b8995@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 27 Jun 2019 12:14:50 +0100, Laatz, Kevin wrote:
> On the application side (xdpsock), we don't have to worry about the user 
> defined headroom, since it is 0, so we only need to account for the 
> XDP_PACKET_HEADROOM when computing the original address (in the default 
> scenario).

That assumes specific layout for the data inside the buffer.  Some NICs
will prepend information like timestamp to the packet, meaning the
packet would start at offset XDP_PACKET_HEADROOM + metadata len..

I think that's very limiting.  What is the challenge in providing
aligned addresses, exactly?
