From: Jakub Kicinski <kuba@kernel.org>
Date: Tue, 22 Mar 2022 11:27:30 -0700
Subject: [Intel-wired-lan] [PATCH v2] ice: use min_t() to make code
 cleaner in ice_gnss
In-Reply-To: <af3fa59809654c9b9939f1e0bd8ca76b@AcuMS.aculab.com>
References: <20220321135947.378250-1-wanjiabing@vivo.com>
 <f888e3cf09944f9aa63532c9f59e69fb@AcuMS.aculab.com>
 <20220322175038.2691665-1-alexandr.lobakin@intel.com>
 <af3fa59809654c9b9939f1e0bd8ca76b@AcuMS.aculab.com>
Message-ID: <20220322112730.482d674d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 22 Mar 2022 18:12:08 +0000 David Laight wrote:
> > > Oh FFS why is that u16?
> > > Don't do arithmetic on anything smaller than 'int'  
> > 
> > Any reasoning? I don't say it's good or bad, just want to hear your
> > arguments (disasms, perf and object code measurements) etc.  
> 
> Look at the object code on anything except x86.
> The compiler has to add instruction to mask the value
> (which is in a full sized register) down to 16 bits
> after every arithmetic operation.

Isn't it also slower on some modern x86 CPUs?
I could have sworn someone mentioned that in the past.
