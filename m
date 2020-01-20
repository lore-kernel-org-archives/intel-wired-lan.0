From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Mon, 20 Jan 2020 18:04:15 +0100
Subject: [Intel-wired-lan] zero-copy between interfaces
In-Reply-To: <20200117171637.GB69024@smtp.ads.isi.edu>
References: <14f9e1bf5c3a41dbaec53f83cb5f0564@isi.edu>
 <CAJ+HfNhdPEe34DVUAj4eHxLkBUSTo2CXbLHoWu+dwFCp753oMg@mail.gmail.com>
 <20200117171637.GB69024@smtp.ads.isi.edu>
Message-ID: <a0f645bc-82b6-5b14-4608-bfde991a6678@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On 2020-01-17 18:16, Ryan Goodfellow wrote:
[...]
> 
> https://gitlab.com/mergetb/tech/network-emulation/kernel/snippets/1931080
> 

Ryan, thanks a lot for the detailed report! Much appreciated!

Long story short, the i40e crash is that the drivers tries to allocate 
256 queues, but the HW is short on queues. The drivers enters a broken 
state, which triggers the crash.

I'll make sure we'll get a patch for this.


Bj?rn
