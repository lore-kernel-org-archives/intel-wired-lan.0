From: Richard Cochran <richardcochran@gmail.com>
Date: Fri, 2 Oct 2015 09:47:16 +0200
Subject: [Intel-wired-lan] [PATCH 03/12] net: igb: avoid using timespec
In-Reply-To: <1803983.ImzkvzgWES@wuerfel>
References: <1443612402-3000775-1-git-send-email-arnd@arndb.de>
 <1443612402-3000775-4-git-send-email-arnd@arndb.de>
 <20151001191745.GC1872@localhost.localdomain>
 <1803983.ImzkvzgWES@wuerfel>
Message-ID: <20151002074716.GA3930@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Oct 01, 2015 at 10:01:57PM +0200, Arnd Bergmann wrote:
> I tried to use this pattern whenever I convert the 64-bit 'long long'
> tv_sec member of 'struct timespec64' into a 32-bit number, to annotate
> the loss of range.

Sounds reasonable to me.
 
> I have thought about defining separate helpers like this
...
> This would make it even more explicit, but my fear was that I was
> adding too much complexity like that.

I think a cast plus a comment when needed is clear enough.

Thanks,
Richard
