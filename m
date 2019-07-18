From: Gavin Lambert <intel@mirality.co.nz>
Date: Thu, 18 Jul 2019 20:06:58 +1200
Subject: [Intel-wired-lan] [e1000e] Linux 4.9: unable to send packets
 after link recovery with patched driver
In-Reply-To: <bec9f546d5a5a46586af0ac93d36f84f@mirality.co.nz>
References: <3acf459ddbbd30687cda0a79523afe04@mirality.co.nz>
 <bec9f546d5a5a46586af0ac93d36f84f@mirality.co.nz>
Message-ID: <000661bda5687541e895a949c76712fb@mirality.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-07-12 15:23, I wrote:
> On 2019-07-11 18:50, I wrote:
>> On a Debian system with kernel linux-image-4.9.0-4-rt-amd64 (4.9.65)
>> installed, this works perfectly.  It also works perfectly with
>> linux-image-4.9.0-8-rt-amd64 (4.9.110).
>> 
>> However, with kernel linux-image-4.9.0-9-rt-amd64 (4.9.168) installed
>> (and no other changes to the system other than building the patched
>> e1000e module against this kernel's headers), something weird happens
>> when the driver is running in its alternate "ecdev" mode.
[...]
> Since this was mostly just a rebase error (you can see a similar
> change in the old location of this code), I'm not sure if this helps
> narrow down the source of the problem between 4.9.110 and 4.9.168 or
> not.  I'm still looking for ideas for that.

Using this kernel tree:
   
https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git/log/?h=v4.9-rt&ofs=3120

I've identified that the code at tag v4.9.126 is "good" and the code at 
tag v4.9.127 is "bad".

I've done a bisect (twice, from different starting points) and both 
times settled on this commit as the one which introduced the problem I'm 
experiencing:

commit c0b809985a7a418fcc3361c239ae79250245282d (refs/bisect/bad)
Author: Tomas Winkler <tomas.winkler@intel.com>
Date:   Tue Jan 2 12:01:41 2018 +0200

     mei: me: allow runtime pm for platform with D0i3

     commit cc365dcf0e56271bedf3de95f88922abe248e951 upstream.

     >From the pci power documentation:
     "The driver itself should not call pm_runtime_allow(), though. 
Instead,
     it should let user space or some platform-specific code do that 
(user space
     can do it via sysfs as stated above)..."

     However, the S0ix residency cannot be reached without MEI device 
getting
     into low power state. Hence, for mei devices that support D0i3, it's 
better
     to make runtime power management mandatory and not rely on the 
system
     integration such as udev rules.
     This policy cannot be applied globally as some older platforms
     were found to have broken power management.

     Cc: <stable@vger.kernel.org> v4.13+
     Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
     Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
     Reviewed-by: Alexander Usyskin <alexander.usyskin@intel.com>
     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

It is reproducible every time; if I build at the parent commit 
(3d3432580911) then the driver works, and if I add the commit above then 
it fails.

However it's unclear to me how this is affecting my modified e1000e 
driver in this way, except that it is perhaps power management related?

Since it appears to be a pm_runtime-related thing, just as an experiment 
I did try commenting out every single call to pm_runtime* functions in 
netdev.c, but this did not resolve the problem.  Ditto for anything with 
the word "suspend" in it.  I also tried adding e_info() logging calls to 
most places that used pm_ calls other than pm_runtime_get/put (and in 
particular, in all of the pm_ops callbacks), and none of them were hit 
during the problem events.

And even when it's not working, if I `cat` various things in 
`/sys/bus/pci/.../power/` on the adapter device, it appears to all be 
non-suspended, which makes me doubt that it really is a PM issue, unless 
I'm just looking in the wrong places.

Any ideas?
