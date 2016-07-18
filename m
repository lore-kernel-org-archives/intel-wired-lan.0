From: Andi Kleen <andi@firstfloor.org>
Date: Mon, 18 Jul 2016 12:49:52 -0700
Subject: [Intel-wired-lan] [RFC PATCH 00/30] Kernel NET policy
In-Reply-To: <37D7C6CF3E00A74B8858931C1DB2F07712C19831@SHSMSX103.ccr.corp.intel.com>
References: <1468824984-65318-1-git-send-email-kan.liang@intel.com>
 <CAKgT0UfA6ShdVta615ZqH8WvedgxSd3SjA5nZ+5EZGROWYa_sg@mail.gmail.com>
 <37D7C6CF3E00A74B8858931C1DB2F07712C19831@SHSMSX103.ccr.corp.intel.com>
Message-ID: <20160718194952.GM5871@two.firstfloor.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> > So where is your policy for power saving?  From past experience I can tell you
> 
> There is no policy for power saving yet. I will add it to my todo list.

Yes it's interesting to consider. The main goal here is to maximize CPU
idle residency? I wonder if that's that much different from the CPU policy.

-Andi
