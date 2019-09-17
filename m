From: Lennart Sorensen <lsorense@csclub.uwaterloo.ca>
Date: Tue, 17 Sep 2019 14:38:16 -0400
Subject: [Intel-wired-lan] [E1000-devel] i40e X722 RSS problem with
 NAT-Traversal IPsec packets
In-Reply-To: <77e940d7-552b-7724-0971-828bdb28add7@toxcorp.com>
References: <20190610190141.77k6gbrefm2mr6lb@csclub.uwaterloo.ca>
 <77e940d7-552b-7724-0971-828bdb28add7@toxcorp.com>
Message-ID: <20190917183815.7xhzmwaw4hy63pmp@csclub.uwaterloo.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Sep 12, 2019 at 12:09:09PM +0200, Jakub Jankowski wrote:
> Was there any progress here?
> 
> As X722 is getting more and more ubiquitous, it's getting harder and harder
> to avoid it. Problems like this, SFP EEPROM readout I reported [1], or the
> recently announced NetCAT issue [2] (X722 seems to support iWARP/RDMA) make
> it really hard to recommend X722 for production use.
> 
> [1]
> https://www.mail-archive.com/e1000-devel at lists.sourceforge.net/msg12550.html
> [2] https://www.vusec.net/projects/netcat/

I haven't seen any update on it.  Still waiting.  I tried to install a
new firmware version, but it claims there is no update to install (same
thing happened with a prior firmware where the new version had the same
version ID as the previous version so the update tool thought there was
nothing to do, and I have a suspicion the same thing happened again).
Not that the firmware updates ever include release notes on what fixes
are included in the update of course, so no idea if it would help.

-- 
Len Sorensen
