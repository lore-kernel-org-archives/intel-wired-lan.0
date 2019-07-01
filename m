From: Jakub Kicinski <jakub.kicinski@netronome.com>
Date: Mon, 1 Jul 2019 14:20:02 -0700
Subject: [Intel-wired-lan] [PATCH 00/11] XDP unaligned chunk placement
 support
In-Reply-To: <07e404eb-f712-b15a-4884-315aff3f7c7d@intel.com>
References: <20190620083924.1996-1-kevin.laatz@intel.com>
 <FA8389B9-F89C-4BFF-95EE-56F702BBCC6D@gmail.com>
 <ef7e9469-e7be-647b-8bb1-da29bc01fa2e@intel.com>
 <20190627142534.4f4b8995@cakuba.netronome.com>
 <f0ca817a-02b4-df22-d01b-7bc07171a4dc@intel.com>
 <BAE24CBF-416D-4665-B2C9-CE1F5EAE28FF@gmail.com>
 <07e404eb-f712-b15a-4884-315aff3f7c7d@intel.com>
Message-ID: <20190701142002.1b17cc0b@cakuba.netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 1 Jul 2019 15:44:29 +0100, Laatz, Kevin wrote:
> On 28/06/2019 21:29, Jonathan Lemon wrote:
> > On 28 Jun 2019, at 9:19, Laatz, Kevin wrote:  
> >> On 27/06/2019 22:25, Jakub Kicinski wrote:  
> >>> I think that's very limiting.? What is the challenge in providing
> >>> aligned addresses, exactly?  
> >> The challenges are two-fold:
> >> 1) it prevents using arbitrary buffer sizes, which will be an issue 
> >> supporting e.g. jumbo frames in future.
> >> 2) higher level user-space frameworks which may want to use AF_XDP, 
> >> such as DPDK, do not currently support having buffers with 'fixed' 
> >> alignment.
> >> ??? The reason that DPDK uses arbitrary placement is that:
> >> ??? ??? - it would stop things working on certain NICs which need the 
> >> actual writable space specified in units of 1k - therefore we need 2k 
> >> + metadata space.
> >> ??? ??? - we place padding between buffers to avoid constantly 
> >> hitting the same memory channels when accessing memory.
> >> ??? ??? - it allows the application to choose the actual buffer size 
> >> it wants to use.
> >> ??? We make use of the above to allow us to speed up processing 
> >> significantly and also reduce the packet buffer memory size.
> >>
> >> ??? Not having arbitrary buffer alignment also means an AF_XDP driver 
> >> for DPDK cannot be a drop-in replacement for existing drivers in 
> >> those frameworks. Even with a new capability to allow an arbitrary 
> >> buffer alignment, existing apps will need to be modified to use that 
> >> new capability.  
> >
> > Since all buffers in the umem are the same chunk size, the original 
> > buffer
> > address can be recalculated with some multiply/shift math. However, 
> > this is
> > more expensive than just a mask operation.  
> 
> Yes, we can do this.

That'd be best, can DPDK reasonably guarantee the slicing is uniform?
E.g. it's not desperate buffer pools with different bases?

> Another option we have is to add a socket option for querying the 
> metadata length from the driver (assuming it doesn't vary per packet). 
> We can use that information to get back to the original address using 
> subtraction.

Unfortunately the metadata depends on the packet and how much info 
the device was able to extract.  So it's variable length.

> Alternatively, we can change the Rx descriptor format to include the 
> metadata length. We could do this in a couple of ways, for example, 
> rather than returning the address as the start of the packet, instead 
> return the buffer address that was passed in, and adding another 16-bit 
> field to specify the start of packet offset with that buffer. If using 
> another 16-bits of the descriptor space is not desirable, an alternative 
> could be to limit umem sizes to e.g. 2^48 bits (256 terabytes should be 
> enough, right :-) ) and use the remaining 16 bits of the address as a 
> packet offset. Other variations on these approach are obviously possible 
> too.

Seems reasonable to me..
