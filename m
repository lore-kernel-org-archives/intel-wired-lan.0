From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 09 Jan 2020 09:43:52 -0800
Subject: [Intel-wired-lan] [PATCH net v2] i40e/iavf: use better trace
 path
In-Reply-To: <07213c35-b4fb-e230-75a2-1d11d51815c9@intel.com>
References: <20200103022342.820175-1-jesse.brandeburg@intel.com>
 <4185adba-3420-32ad-014d-64eee768d183@intel.com>
 <07213c35-b4fb-e230-75a2-1d11d51815c9@intel.com>
Message-ID: <9400163aa83bbd414e43e2aebd5d9e1e23e394b5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2020-01-08 at 14:55 -0800, Jacob Keller wrote:
> On 1/8/2020 2:49 PM, Jacob Keller wrote:
> > On 1/2/2020 6:23 PM, Jesse Brandeburg wrote:
> > > I'm seeing compilation fail of the i40e/iavf driver for some
> > > reason.
> > > I just checked 5.5-rc4 and the tip of net/net-next and all fail.
> > > Fails all the way back to v5.1 at least, I didn't check further
> > > back.
> > > 
> > > repro steps:
> > > $ gcc -v
> > > gcc version 9.2.1 20190827 (Red Hat 9.2.1-1) (GCC)
> > > 
> > > $ git checkout -b my-net davem-net/master
> > > $ make mrproper
> > > $ make O=../my-net.obj defconfig allmodconfig modules_prepare
> > > $ make O=../my-net.obj M=drivers/net/ethernet/intel/i40e
> > > 
> > > make[1]: Entering directory '/home/jbrandeb/git/my-net.obj'
> > >   CC [M]  drivers/net/ethernet/intel/i40e/i40e_main.o
> > > In file included from
> > > /home/jbrandeb/git/linux2/drivers/net/ethernet/intel/i40e/i40e_tr
> > > ace.h:209,
> > >                  from
> > > /home/jbrandeb/git/linux2/drivers/net/ethernet/intel/i40e/i40e_ma
> > > in.c:20:
> > > /home/jbrandeb/git/linux2/include/trace/define_trace.h:95:42:
> > > fatal error: ./i40e_trace.h: No such file or directory
> > >    95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
> > >       |                                          ^
> > > compilation terminated.
> > > make[2]: ***
> > > [/home/jbrandeb/git/linux2/scripts/Makefile.build:266:
> > > drivers/net/ethernet/intel/i40e/i40e_main.o] Error 1
> > > make[1]: *** [/home/jbrandeb/git/linux2/Makefile:1693:
> > > drivers/net/ethernet/intel/i40e] Error 2
> > > make[1]: Leaving directory '/home/jbrandeb/git/my-net.obj'
> > > make: *** [Makefile:179: sub-make] Error 2
> > > 
> > > Just for sanity, I tried building the ice driver the same as
> > > above and
> > > it succeeds, so the build does work for some drivers.
> > > 
> > 
> > So.. ice works for some reason but i40e and iavf do not? Is the ice
> > driver using a path relative to the root?
> > 
> > > So fix the include path for the i40e driver trace file to be
> > > relative
> > > to the kernel root like (some) other drivers do.
> > 
> > I'd really like to know why this isn't required by all drivers...
> > 
> 
> It looks like this is handled in driver's Makefile via:
> 
> ccflags-y += -I$(src)>-->------->-------# needed for trace events
> 
> or the following:
> 
> CFLAGS_trace.o := -I$(src)

I like the above solution, as it is much cleaner and less prone for
future errors, if the directory patch would change for whatever reason.

> 
> This seems like the preferred solution when building with a separate
> object tree.
> 
> Thanks,
> Jake
> _______________________________________________
> Intel-wired-lan mailing list
> Intel-wired-lan at osuosl.org
> https://lists.osuosl.org/mailman/listinfo/intel-wired-lan

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200109/2c9dd3ad/attachment.asc>
