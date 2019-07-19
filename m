From: Gavin Lambert <intel@mirality.co.nz>
Date: Fri, 19 Jul 2019 12:40:10 +1200
Subject: [Intel-wired-lan] [e1000e] Linux 4.9: unable to send packets
 after link recovery with patched driver
In-Reply-To: <d3118220-e599-44cd-5ed6-43259c5fc2c2@intel.com>
References: <3acf459ddbbd30687cda0a79523afe04@mirality.co.nz>
 <bec9f546d5a5a46586af0ac93d36f84f@mirality.co.nz>
 <000661bda5687541e895a949c76712fb@mirality.co.nz>
 <d3118220-e599-44cd-5ed6-43259c5fc2c2@intel.com>
Message-ID: <3a63201c552a9cb6a9737fec92bc1264@mirality.co.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2019-07-18 20:24, Neftin, Sasha wrote:
> Please, refer to the commit def4ec6dce393e2136b62a05712f35a7fa5f5e56
> on the Jeff Kirsher's next-queue:
> https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git/commit/drivers/net/ethernet/intel/e1000e?id=def4ec6dce393e2136b62a05712f35a7fa5f5e56
> 
> We are working to push this patch to upstream.

Thanks, that does sound identical to my symptoms.

However I tried applying this patch to my driver in 4.9 and it does not 
resolve the problem.

Are some additional patches required as well?


FWIW, I added some extra logging around the new code.  I can confirm 
that it does execute on link regain but doesn't actually enter the loop 
in my problem case.  The pcim_state is 0x00080083 at the time.  So the 
e1000_phy_hw_reset is never actually called.  If I try changing it to 
call that unconditionally, then it can't successfully establish a link 
in the first place.
