From: Laatz, Kevin <kevin.laatz@intel.com>
Date: Fri, 28 Jun 2019 17:19:09 +0100
Subject: [Intel-wired-lan] [PATCH 00/11] XDP unaligned chunk placement
 support
In-Reply-To: <20190627142534.4f4b8995@cakuba.netronome.com>
References: <20190620083924.1996-1-kevin.laatz@intel.com>
 <FA8389B9-F89C-4BFF-95EE-56F702BBCC6D@gmail.com>
 <ef7e9469-e7be-647b-8bb1-da29bc01fa2e@intel.com>
 <20190627142534.4f4b8995@cakuba.netronome.com>
Message-ID: <f0ca817a-02b4-df22-d01b-7bc07171a4dc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 27/06/2019 22:25, Jakub Kicinski wrote:
> On Thu, 27 Jun 2019 12:14:50 +0100, Laatz, Kevin wrote:
>> On the application side (xdpsock), we don't have to worry about the user
>> defined headroom, since it is 0, so we only need to account for the
>> XDP_PACKET_HEADROOM when computing the original address (in the default
>> scenario).
> That assumes specific layout for the data inside the buffer.  Some NICs
> will prepend information like timestamp to the packet, meaning the
> packet would start at offset XDP_PACKET_HEADROOM + metadata len..

Yes, if NICs prepend extra data to the packet that would be a problem for
using this feature in isolation. However, if we also add in support for 
in-order
RX and TX rings, that would no longer be an issue. However, even for NICs
which do prepend data, this patchset should not break anything that is 
currently
working.

>
> I think that's very limiting.  What is the challenge in providing
> aligned addresses, exactly?
The challenges are two-fold:
1) it prevents using arbitrary buffer sizes, which will be an issue 
supporting e.g. jumbo frames in future.
2) higher level user-space frameworks which may want to use AF_XDP, such 
as DPDK, do not currently support having buffers with 'fixed' alignment.
 ??? The reason that DPDK uses arbitrary placement is that:
 ??? ??? - it would stop things working on certain NICs which need the 
actual writable space specified in units of 1k - therefore we need 2k + 
metadata space.
 ??? ??? - we place padding between buffers to avoid constantly hitting 
the same memory channels when accessing memory.
 ??? ??? - it allows the application to choose the actual buffer size it 
wants to use.
 ??? We make use of the above to allow us to speed up processing 
significantly and also reduce the packet buffer memory size.

 ??? Not having arbitrary buffer alignment also means an AF_XDP driver 
for DPDK cannot be a drop-in replacement for existing drivers in those 
frameworks. Even with a new capability to allow an arbitrary buffer 
alignment, existing apps will need to be modified to use that new 
capability.

