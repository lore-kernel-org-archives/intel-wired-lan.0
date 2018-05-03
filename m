From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Thu, 03 May 2018 14:23:09 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: release lock for the
 duration of ixgbe_suspend_close()
In-Reply-To: <50c9ac34-3971-ac1b-0b5e-1bfa004fd4cf@oracle.com>
References: <20180503035931.22439-1-pasha.tatashin@oracle.com>
 <20180503035931.22439-2-pasha.tatashin@oracle.com>
 <CAKgT0UdocfEm9oXZ1dkEMari8m3OA4uVTrYg45uj9fk2V41bxQ@mail.gmail.com>
 <CAGM2rea3XXJ7OqGeAdexyOUb1_7W_84t5HAb_hp7Rb=TkTM86Q@mail.gmail.com>
 <CAKgT0UfNBugQywBZuepUJ6deEYsSWmTw3b6VbQBJLn-kKXe7ng@mail.gmail.com>
 <50c9ac34-3971-ac1b-0b5e-1bfa004fd4cf@oracle.com>
Message-ID: <CAGM2reZULTOcK+_VypXJjkkCNZbALuR_FS-t7ix-Wpq6AKXdjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Hi Pavel, you might want to pull lock optimization out of this patch
series.
> The parallelization by itself is valuable, and optimizations for
individual
> devices including locks can come later.

Hi Steve,

Yes, I will pull this patch out of the series. Thank you for the suggestion.

Pavel
